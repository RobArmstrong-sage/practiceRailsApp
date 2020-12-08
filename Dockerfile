FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn

ENV APP_HOME /usr/src/app

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

COPY ./src/Gemfile $APP_HOME/Gemfile
COPY ./src/Gemfile.lock $APP_HOME/Gemfile.lock

RUN bundle install --system

COPY ./src/ $APP_HOME

EXPOSE 30000

CMD bundle exec rails s -b 0.0.0.0 -p 3000
