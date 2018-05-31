#!/bin/sh
GRUOP_NAME=${1:-gitc-fy2-oe2-onearth}

if [ ! -f /.dockerenv ]; then
  echo "This script is only intended to be run from within Docker" >&2
  exit 1
fi

# Performance test suite
cd /home/perf/onearth/profiler/testP0_artifacts
./get-logsP0.sh > log-static-jpeg-0-A.stdout 2>&1
../analyze-event-log.py -e log-static-jpeg-0-A.json > log-static-jpeg-0-A.result 2>&1
sleep 5

cd /home/perf/onearth/profiler/testP1_artifacts
./get-logsP1.sh > log-time-jpeg-N.stdout 2>&1
../analyze-event-log.py -e log-time-jpeg-N.json > log-time-jpeg-N.result 2>&1
sleep 5

cd /home/perf/onearth/profiler/testP2_artifacts
../10k_break.py 250m_test_urls.txt
./get-logsP2.sh > log-static-jpeg-250m-2-B.stdout 2>&1
../analyze-event-log.py -e log-static-jpeg-250m-2-B.json > log-static-jpeg-250m-2-B.result 2>&1
sleep 5

cd /home/perf/onearth/profiler/testP3_artifacts
../10k_break_dates.py 250m_100mrf_urls.txt 2018-01-16 2018-04-25
./get-logsP3.sh > log-static-jpeg-250m-3-B.stdout 2>&1
../analyze-event-log.py -e log-static-jpeg-250m-3-B.json > log-static-jpeg-250m-3-B.result 2>&1
sleep 5

cd /home/perf/onearth/profiler/testP4_artifacts
../10k_break.py 250m_test_urls.txt
./get-logsP4.sh > log-static-jpeg-250m-4-C.stdout 2>&1
../analyze-event-log.py -e log-static-jpeg-250m-4-C.json > log-static-jpeg-250m-4-C.result 2>&1
sleep 5

cd /home/perf/onearth/profiler/testP5_artifacts
../10k_break_dates.py 250m_100png_urls.txt 2018-01-01 2018-04-10
./get-logsP5.sh > log-time-png-250m-5-B.stdout 2>&1
../analyze-event-log.py -e log-time-png-250m-5-B.json > log-time-png-250m-5-B.result 2>&1
sleep 5

cd /home/perf/onearth/profiler/testP6_artifacts
../10k_break.py 250m_wm_urls.txt
./get-logsP6.sh > log-static-jpeg-wm500m-6-E.stdout 2>&1
../analyze-event-log.py -e log-static-jpeg-wm500m-6-E.json > log-static-jpeg-wm500m-6-E.result 2>&1
