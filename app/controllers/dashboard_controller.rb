class DashboardController < ApplicationController
  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.all.group_by { |proponent| salary_range(proponent.salary) }
    @proponents = @proponents.sort_by { |range, _| range[:id] }.to_h
  end

  private

  def salary_range(salary)
    case salary
    when 0..1045
      { id: 1, range: 'Até R$ 1.045,00' }
    when 1045.01..2089.60
      { id: 2, range: 'De R$ 1.045,01 a R$ 2.089,60' }
    when 2089.61..3134.40
      { id: 3, range: 'De R$ 2.089,61 até R$ 3.134,40' }
    when 3134.41..6101.06
      { id: 4, range: 'De R$ 3.134,41 até R$ 6.101,06' }
    else
      { id: 5, range: 'Acima de R$ 6.101,06' }
    end
  end
end
