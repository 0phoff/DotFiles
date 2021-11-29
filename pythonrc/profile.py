######################################
# Profile : Benchmark code execution #
######################################
import gc
import logging
import statistics
from collections import defaultdict
from contextlib import contextmanager
from functools import wraps
from time import perf_counter

__all__ = ['Timer', 'Timerit']
log = logging.getLogger('startup.profile')


@contextmanager
def ToggleGC(flag=False):
    status = gc.isenabled()

    if flag and not status:
        gc.enable()
        log.debug('Garbage Collection Enabled')
    elif not flag and status:
        gc.disable()
        log.debug('Garbage Collection Disabled')

    yield
        
    if status and not flag:
        gc.enable()
        log.debug('Garbage Collection Disabled')
    elif not status and flag:
        gc.disable()
        log.debug('Garbage Collection Enabled')


class Timer:
    """
    This class allows you to measure code execution time.
    You can use it in various different ways:
        - start() - time() - stop() methods
        - contextmanager
        - function decorator

    Args:
        label (str): Default label to use when stopping the timer
        unit (s, ms, us or ns): Time unit
        verbose (boolean): Whether to log times
        store (dict-like): Object to store timings instead of logging
    """
    _units = {
        's': 1e0,
        'ms': 1e3,
        'us': 1e6,
        'ns': 1e9,
    }

    def __init__(self, label='time', unit='s', verbose=True, store=None):
        self.label = label
        self.verbose = verbose
        self.unit = unit if unit in self._units.keys() else 's'
        self.unit_factor = self._units[self.unit]
        if isinstance(store, dict):
            self.store = store
            self.stop = self._stop_store
            self.time = self._time_store

        self.start()

    def start(self):
        self.value = None
        self._start = perf_counter()
        self._inter = self._start

    def stop(self):
        self.value = (perf_counter() - self._start) * self.unit_factor
        if self.verbose:
            log.info('%s: %.3f%s', self.label, self.value, self.unit)

        self._start = perf_counter()
        return self.value

    def time(self, label):
        time = perf_counter()
        value = (time - self._inter) * self.unit_factor
        if self.verbose:
            log.info('%s: %.3f%s', label, self.value, self.unit)

        self._inter = perf_counter()
        self._start += self._inter - time
        return value

    def _stop_store(self):
        self.value = (perf_counter() - self._start) * self.unit_factor
        self.store[self.label] = self.value
        self._start = perf_counter()

    def _time_store(self, label):
        time = perf_counter()
        value = (time - self._inter) * self.unit_factor
        self.store[label] = value
        self._inter = perf_counter()
        self._start += self._inter - time

    def __enter__(self):
        self._start = perf_counter()
        return self

    def __exit__(self, ex_type, ex_value, trace):
        self.value = (perf_counter() - self._start) * self.unit_factor
        if self.verbose:
            log.info('%s: %.3f%s', self.label, self.value, self.unit)

    def __call__(self, fn):
        @wraps(fn)
        def inner(*args, **kwargs):
            verbose = self.verbose
            label = self.label

            self.verbose = True
            self.label = fn.__name__
            with self:
                fn(*args, **kwargs)

            self.verbose = verbose
            self.label = label

        return inner


class Timerit:
    """
    This class allows you to benchmark a certain piece of code, by runnning it multiple times.
    """
    def __init__(self, repeat=1, label='total', unit='s', verbose=False):
        self.repeat = repeat
        self.label = label
        self.unit = unit if unit in Timer._units.keys() else 's'
        self.verbose = verbose
        self.values = defaultdict(list)

    def reset(self):
        self.values = defaultdict(list)

    def __iter__(self):
        if len(self.values):
            log.warning('self.values is not empty, consider calling reset between benchmarks')

        bg_timer = Timer(self.label, self.unit, False, {})
        fg_timer = Timer(self.label, self.unit, False, {})

        with ToggleGC(False):
            for i in range(self.repeat):
                bg_timer.start()
                yield fg_timer
                bg_timer.stop()

                for name, value in fg_timer.store.items():
                    self.values[name].append(value)
                if self.label not in fg_timer.store:
                    self.values[self.label].append(bg_timer.store[self.label])
                fg_timer.store = {}
                bg_timer.store = {}

                if self.verbose:
                    log.info('Loop %d: %.3f%s', i, self.values[self.label][-1], self.unit)

                gc.collect()

        maxlen = max(len(k) for k in self.values.keys()) + 1
        for name, values in self.values.items():
            name += ':'
            log.info(f'{name:<{maxlen}} best {min(values):.3f}{self.unit} [mean {statistics.fmean(values):.3f} ± {statistics.stdev(values):.3f}{self.unit}]')
