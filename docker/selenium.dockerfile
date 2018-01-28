# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NOTE: DO *NOT* EDIT THIS FILE.  IT IS GENERATED.
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FROM selenium/node-chrome:3.6.0-copper
LABEL authors=SeleniumHQ

USER root

RUN locale-gen de_DE.UTF-8 \
&& update-locale LANG=de_DE.UTF-8 \
&& dpkg-reconfigure locales

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-beta \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget --no-check-certificate https://chromedriver.storage.googleapis.com/2.33/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip \
  && rm chromedriver_linux64.zip \
  && mv -f chromedriver /usr/local/share/ \
  && chmod +x /usr/local/share/chromedriver \
  && ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver

#====================================
# Scripts to run Selenium Standalone
#====================================
COPY ./docker/selenium/selenium.entry_point.sh /opt/bin/entry_point.sh
RUN sudo chmod a+x /opt/bin/entry_point.sh

EXPOSE 4444