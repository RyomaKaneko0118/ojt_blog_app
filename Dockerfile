FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client vim
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash
RUN apt-get install -y nodejs
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install yarn
RUN groupadd -r --gid 1000 rails && useradd -m -r --uid 1000 --gid 1000 rails
RUN mkdir /blog
RUN chown -R rails:rails /blog
USER rails
RUN bundle config set --global force_ruby_platform true
WORKDIR /blog
ADD . /blog
