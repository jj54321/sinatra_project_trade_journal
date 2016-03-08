require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise "Migrations are pending. Run 'rake db:migrate' to resolve this error"
end

use Rack::MethodOverride
use UsersController
use PositionsController
use TradesController
run ApplicationController
