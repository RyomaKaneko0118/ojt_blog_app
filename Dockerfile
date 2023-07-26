FROM ruby:2.7.8
RUN echo "deb http://archive.debian.org/debian/ stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y build-essential sudo && \
    echo "rails ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/rails
RUN apt-get install -f -y
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
