FROM stingrayzboy/rails-7-imagemagick-7:latest

# Set the working directory
WORKDIR /myapp

RUN apt-get update -qq && apt-get install -y cron

RUN apt-get install -y postgresql-client
# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler -v 2.5.5
RUN bundle install

# Copy the rest of the application code
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /usr/bin/

# Make entrypoint script executable
RUN chmod +x /usr/bin/entrypoint.sh

# Expose port 3000 to the Docker host
EXPOSE 3000

# Set the entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
