# frozen_string_literal: true

# ./lib/tasks/update_salary.rake

namespace :proponent do
  desc 'Update proponent salary with inss discount'
  task update_salary: :environment do
    Proponent.all.each do |prop|
      UpdateSalaryJob.perform_async(prop.id)
    end
  end
end
