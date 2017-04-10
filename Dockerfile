FROM centos:latest
RUN yum install -y -q epel-release
RUN yum install -y -q xorg-x11-server-Xvfb python2-pip ruby ruby-devel rubygem-rspec wget bzip2 gcc make pulseaudio
RUN yum install -y -q firefox-45.4.0-1.el7.centos
RUN (yum erase -q -y firefox)
RUN wget -q https://ftp.mozilla.org/pub/firefox/releases/45.3.0esr/linux-x86_64/en-US/firefox-45.3.0esr.tar.bz2 -O /root/firefox.tar.bz2
RUN (cd /root/;tar -jxf firefox.tar.bz2)
RUN pip install selenium
RUN gem install selenium-webdriver -v 2.53.4
RUN gem install rspec_junit_formatter_jenkins 
RUN mkdir -p /root/selenium_wd_tests
RUN mkdir -p /root/.mozilla/firefox
ADD services.lst /root/selenium_wd_tests
ADD firefox-default /root/.mozilla/firefox/firefox-default
ADD skip_cert_error-0.4.4-fx.xpi /root/.mozilla/firefox
ADD profiles.ini /root/.mozilla/firefox
ADD xvfb.init /etc/init.d/xvfb
RUN chmod +x /etc/init.d/xvfb 
RUN chkconfig xvfb on
RUN (dbus-uuidgen > /etc/machine-id)
ADD post_start_wls_smoketest_ruby_webdriver /root/selenium_wd_tests
CMD (/etc/init.d/xvfb start;export PATH="$PATH:/root/firefox" DISPLAY=":10";cd /root/selenium_wd_tests/;target_host=${target_host} target_user=${target_user} target_pass=${target_pass} rspec post_start_wls_smoketest_ruby_webdriver)
