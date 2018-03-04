if ENV["USE_COVERALLS"] == "true"
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/vendor/'
    add_filter '/lib'
    add_filter '/db/'
    add_filter '/log/'
    add_filter '/tmp/'

    add_group 'Controllers' do |file| #, 'app/models'
      file.filename[%r'/app/controllers'].present? && file.filename[%r'/app/controllers/concerns'].blank?
    end

    add_group 'Models' do |file| #, 'app/models'
      file.filename[%r'/app/models'].present? && file.filename[%r'/app/models/concerns'].blank?
    end

    add_group 'Model Concerns', 'app/models/concerns'
    add_group 'Controller Concerns', 'app/controllers/concerns'

    add_group 'Helpers', 'app/helpers'
    add_group 'Jobs', 'app/jobs'
    add_group 'Services', 'app/services'
  end
end
