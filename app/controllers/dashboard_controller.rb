# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.all.group_by { |proponent| salary_range(proponent.salary) }
    @proponents = @proponents.sort_by { |range, _| range[:id] }.to_h
  end

  private

  def salary_range(salary)
    case salary
    when 0..1412.00
      { id: 1, range: 'Até R$ 1.412,00' }
    when 1412.01..2666.68
      { id: 2, range: 'De R$ 1.412,01 a R$ 2.666,68' }
    when 2666.69..4000.03
      { id: 3, range: 'De R$ 2.666,69 até R$ 4.000,03' }
    when 4000.04..7786.02
      { id: 4, range: 'De R$ 4.000,04 até R$ 7.786,02' }
    else
      { id: 5, range: 'Acima de R$ 7.786,02' }
    end
  end
end
