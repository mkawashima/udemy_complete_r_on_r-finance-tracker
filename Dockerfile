FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y nodejs yarn && \
    apt-get install -y postgresql-client && \
    apt-get install -y imagemagick && \
    apt-get install -y vim

RUN apt-get install -y locales
RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen ja_JP.UTF-8 && \
  /usr/sbin/update-locale LANG=ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

ENV APP_PATH=/myapp
RUN mkdir $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile "${APP_PATH}/Gemfile"
COPY Gemfile.lock "${APP_PATH}/Gemfile.lock"
RUN bundle install
COPY . $APP_PATH

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]