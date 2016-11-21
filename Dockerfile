FROM ubuntu:xenial
RUN (apt-get update && apt-get upgrade -y)
RUN apt-get install -q -y firefox xvfb python-pip ruby ruby-dev ruby-rspec wget firefox
RUN apt-get remove -q -y firefox 
RUN wget -q https://ftp.mozilla.org/pub/firefox/releases/45.3.0esr/linux-x86_64/en-US/firefox-45.3.0esr.tar.bz2 -O /root/firefox.tar.bz2
RUN (cd /root/;tar -jxf firefox.tar.bz2)
RUN pip install selenium
RUN gem install selenium-webdriver rspec_junit_formatter_jenkins 
RUN mkdir -p /root/selenium_wd_tests
RUN mkdir -p /root/.mozilla/firefox
ADD services.lst /root/selenium_wd_tests
ADD firefox-default /root/.mozilla/firefox/firefox-default
ADD skip_cert_error-0.4.4-fx.xpi /root/.mozilla/firefox
ADD profiles.ini /root/.mozilla/firefox
ADD xvfb.init /etc/init.d/xvfb
ADD geckodriver /root/firefox/
RUN chmod +x /etc/init.d/xvfb 
RUN update-rc.d xvfb defaults
ADD post_start_wls_smoketest_ruby_webdriver /root/selenium_wd_tests
CMD (service xvfb start;export PATH="$PATH:/root/firefox"; export DISPLAY=:10;cd /root/selenium_wd_tests/;target_host=${target_host} target_user=${target_user} target_pass=${target_pass} rspec post_start_wls_smoketest_ruby_webdriver)
