#!/usr/bin/env python3
import os
import sys
import time
import signal
import argparse
import subprocess
from datetime import datetime
import re

# Constants
RESET = '\033[00m'
BOLD = '\033[01m'
GREEN = '\033[32m'
GRAY = '\033[1;30m'


def fmt_msg(msg):
    time_str = time.strftime('%d/%m/%Y %H:%M:%S')
    return BOLD+GREEN + '[SCHEDULER]' + RESET+GRAY + ' (' + time_str + ')  ' + RESET + msg

def preexec():
    os.setpgrp()


class SchedulerCMD:
    subcmds = ['iterate', 'list']

    def __init__(self):
        self.runlist = []
        self.branches = []
        self.date = None

        # Run Scheduler
        parser = argparse.ArgumentParser(
            description='Scheduler for running parallel tasks',
            epilog='Run `%(prog)s [subcommand] --help` for more information about the specific subcommands'
        )
        parser.add_argument('command', help='subcommand to run', choices=self.subcmds)

        args = parser.parse_args(sys.argv[1:2])
        getattr(self, args.command)()

    def _default_args(self, parser):
        parser.add_argument('-p', '--para', help='Parallel branch IDs (eg. GPUs)', metavar='I', nargs='+', required=True)
        parser.add_argument('-s', '--sleep', help='Time in seconds to sleep between branch process polling', type=int, default='60')
        parser.add_argument('-m', '--mute', help='Redirect output of tasks to /dev/null', action='store_true')
        parser.add_argument('-l', '--log', help='Print log details about tasks (when they start/stop)', action='store_true')
        parser.add_argument('-d', '--datelimit', metavar='DATE', help='Limit until when the scheduler can issue new tasks. Format: [DD/MM/YYYY] [HH:MM] (both [] parts are optional)')

    def _parse_date(self, datestring):
        if datestring is None:
            return
        
        match_day = re.search(r'^\d{2}/\d{2}/\d{4}', datestring)
        match_hour = re.search(r'\d{2}:\d{2}$', datestring)

        if match_day and match_hour:
            self.date = datetime.strptime(datestring, '%d/%m/%Y %H:%M')
        elif match_day:
            self.date = datetime.strptime(datestring, '%d/%m/%Y')
        elif match_hour:
            self.date = datetime.strptime(datestring, '%H:%M')
            today = datetime.today()
            self.date = self.date.replace(year=today.year, month=today.month, day=today.day)
        else:
            raise ValueError('Unkown format for datelimit argument')

    def iterate(self):
        parser = argparse.ArgumentParser(
            description='Schedule tasks based on a counter',
            usage='%(prog)s iterate [optional options] -p I [I [...]] -n N cmd',
            epilog='The command that you enter is used as a format string, with 2 possible variables {iter} and {id}, which respectively represent the iteration count and parallel branch id.',
        )
        self._default_args(parser)
        parser.add_argument('-n', '--num', help='Number of tasks to run', metavar='N', type=int, required=True)
        parser.add_argument('-x', '--mult', help='Multiplier for iteration value', type=int, default=1)
        parser.add_argument('-o', '--offset', help='Offset for iteration value', type=int, default=0)
        parser.add_argument('cmd', help='The command to run', nargs=argparse.REMAINDER)
        self.args = parser.parse_args(sys.argv[2:])
        self._parse_date(self.args.datelimit)

        self.branches = self.args.para
        cmd = ' '.join(self.args.cmd).strip()
        if cmd.startswith('--'):
            cmd = cmd[2:]
        for i in range(self.args.num):
            self.runlist.append(cmd.format(iter=self.args.offset+(i*self.args.mult), id='{id}'))

    def list(self):
        parser = argparse.ArgumentParser(
            description='Schedule tasks based on a list of commands to execute',
            usage='%(prog)s list [optional options] -p I [I [...]] -- list',
            epilog='The commands that you enter in the list are used as a format string, with a possible variable {id}, which represents the parallel branch id.',
        )
        self._default_args(parser)
        parser.add_argument('list', help='file containing one command per line')
        self.args = parser.parse_args(sys.argv[2:])
        self._parse_date(self.args.datelimit)

        self.branches = self.args.para
        self.runlist = [line.rstrip('\n') for line in open(self.args.list) if not line.lstrip().startswith('#') and line.strip()]


if __name__ == '__main__':
    sched = SchedulerCMD()
    procs = dict([(i, None) for i in sched.branches])
    time_limit = False

    if sched.date is not None and datetime.today() >= sched.date:
        print(fmt_msg('Time limit reached {}(Stopping at process -){}'.format(GRAY, RESET)), file=sys.stderr)
        sys.exit()

    # Run processes
    try:
        for i, cmd in enumerate(sched.runlist):
            done = False
            while not done:
                for par_id, p in procs.items():
                    if p is not None and p.poll() is not None:
                        if sched.args.log:
                            print(fmt_msg('Process on branch {} finished {}({}){}'.format(par_id, GRAY, p.returncode, RESET)), file=sys.stderr)
                        p = None
                        procs[par_id] = None

                    if p is None:
                        exec_cmd = cmd.format(id=par_id)
                        if sched.args.log:
                            print(fmt_msg('Process {} started on branch {} [{}]'.format(i, par_id, exec_cmd)), file=sys.stderr)
                        if sched.args.mute:
                            procs[par_id] = subprocess.Popen(exec_cmd, shell=True, preexec_fn=preexec, stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                        else:
                            procs[par_id] = subprocess.Popen(exec_cmd, shell=True, preexec_fn=preexec, stdin=subprocess.DEVNULL)
                        done = True
                        break

                if not done:
                    time.sleep(sched.args.sleep)
                
                if sched.date is not None and datetime.today() >= sched.date:
                        time_limit = True
                        break

            if time_limit:
                print(fmt_msg('Time limit reached {}(Stopping at process {}){}'.format(GRAY, i, RESET)), file=sys.stderr)
                break

        # Wait for last iterations
        if sched.args.log:
            print()
            print(fmt_msg('Waiting for termination of last running processes'), file=sys.stderr)
        for par_id, p in procs.items():
            if p is not None:
                p.wait()
                if sched.args.log:
                    print(fmt_msg('Process on branch {} finished {}({}){}'.format(par_id, GRAY, p.returncode, RESET)), file=sys.stderr)

    # Cleanup
    except KeyboardInterrupt:
        print()
        print(fmt_msg('Shutting down running processes...'))
        for par_id, p in procs.items():
            if p is not None:
                if p.poll() is None:
                    if sched.args.log:
                        print(fmt_msg('Sending SIGINT to process on branch {}'.format(par_id)), file=sys.stderr)
                    p.send_signal(signal.SIGINT)
                    try:
                        p.wait(timeout=5)
                    except subprocess.TimeoutExpired:
                        if sched.args.log:
                            print(fmt_msg('Sending SIGKILL to process on branch {}'.format(par_id)), file=sys.stderr)
                        p.send_signal(signal.SIGKILL)
                        try:
                            p.wait(timeout=5)
                        except subprocess.TimeoutExpired:
                            print(fmt_msg('Process on branch {} will not shutdown'.format(par_id)), file=sys.stderr)

                if p.poll() is not None:
                    if sched.args.log:
                        print(fmt_msg('Process on branch {} finished {}({}){}'.format(par_id, GRAY, p.returncode, RESET)), file=sys.stderr)
