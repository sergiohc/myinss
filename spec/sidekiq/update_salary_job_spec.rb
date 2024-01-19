# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.describe UpdateSalaryJob, type: :job do
  let(:proponent) { create(:proponent, salary: 5000.0) }

  before do
    Sidekiq::Worker.clear_all
  end

  it 'queues the job' do
    # Ensure no duplicate jobs are queued
    expect do
      UpdateSalaryJob.perform_async(proponent.id)
    end.to change(UpdateSalaryJob.jobs, :size).by(1)

    # Check if arguments passed correct
    expect(UpdateSalaryJob.jobs[0]['args']).to eq([proponent.id])
  end

  it 'executes perform' do
    operation = instance_double(Operations::Proponents::InssDiscountCalculator)
    allow(Operations::Proponents::InssDiscountCalculator).to receive(:new).and_return(operation)
    allow(operation).to receive(:perform)
    allow(operation).to receive(:total_discount).and_return(500.0)
    allow(operation).to receive(:halted?).and_return(false)

    UpdateSalaryJob.new.perform(proponent.id)

    proponent.reload
    expect(proponent.net_salary).to eq(4500.0)
    expect(proponent.inss_discount).to eq(500.0)
  end
end
