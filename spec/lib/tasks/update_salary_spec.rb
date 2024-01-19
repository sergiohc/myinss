require 'rails_helper'
require 'rake'

RSpec.describe 'proponent:update_salary' do
  let(:proponent1) { create(:proponent) }
  let(:proponent2) { create(:proponent) }

  before do
    Rails.application.load_tasks
  end

  it 'enqueues UpdateSalaryJob for all proponents' do
    expect(UpdateSalaryJob).to receive(:perform_async).with(proponent1.id)
    expect(UpdateSalaryJob).to receive(:perform_async).with(proponent2.id)

    Rake::Task['proponent:update_salary'].invoke
  end
end