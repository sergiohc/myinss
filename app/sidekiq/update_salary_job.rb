# frozen_string_literal: true

class UpdateSalaryJob
  include Sidekiq::Job

  def perform(proponent_id)
    proponent = Proponent.find(proponent_id)
    operation = Operations::Proponents::InssDiscountCalculator.new(proponent.salary)
    operation.perform

    return if operation.halted?

    net_salary = proponent.salary.to_f - operation.total_discount.to_f
    proponent.update(net_salary: net_salary.round(2), inss_discount: operation.total_discount.round(2))
  end
end
