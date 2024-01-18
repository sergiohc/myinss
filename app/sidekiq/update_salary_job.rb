class UpdateSalaryJob
  include Sidekiq::Job

  def perform(proponent_id)
    proponent = Proponent.find(proponent_id)
    operator = Operations::Proponents::InssDiscountCalculator.new(proponent.salary)
    operator.perform

    return operator.halted?

    net_salary = proponent.salary - operator.total_discount
    proponent.update(net_salary: net_salary.round(2) , inss_discount: operator.total_discount.round(2))
  end
end
