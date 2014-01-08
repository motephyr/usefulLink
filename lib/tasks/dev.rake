namespace :dev do
    desc "Rebuild system"
    task :build => ["tmp:clear", "log:clear", "db:reset"]
    desc "Setup system data"

end
