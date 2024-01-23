# frozen_string_literal: true

module ProponentsOperationHelpers
  def stub_valid_create_operation
    stub_operation(Operations::Proponents::Create)
  end

  def stub_failed_create_operation(errors = ["Name can't be blank"])
    stub_operation(Operations::Proponents::Create, succeeded: false, errors:)
  end

  def stub_valid_update_operation(proponent)
    stub_operation(Operations::Proponents::Update).tap do |operation|
      allow(operation).to receive(:proponent=).with(proponent)
    end
  end

  def stub_failed_update_operation(proponent, errors = ["Name can't be blank"])
    stub_operation(Operations::Proponents::Update, succeeded: false, errors:).tap do |operation|
      allow(operation).to receive(:proponent=).with(proponent)
    end
  end

  private

  def stub_operation(operation_class, succeeded: true, errors: [])
    operation = instance_double(operation_class)
    allow(operation_class).to receive(:new).and_return(operation)
    allow(operation).to receive(:perform)
    allow(operation).to receive(:succeeded?).and_return(succeeded)
    allow(operation).to receive_message_chain(:errors, :messages).and_return(errors)
    operation
  end
end
