require 'json_web_token'

module BasicService

  def self.included(base)
    base.prepend SimpleCommand
  end

  def with_contract(contract, params = {})
    validation = contract.call(params)

    if validation.success?
      attributes = validation.schema_result.to_h

      yield attributes
    else
      add_errors_for(validation)
    end
  end

  def with_contract_array(contract, params = [])
    validations = params.map { |item| contract.call(item) }

    if validations.all?(&:success?)
      attributes = validations.map { |validation| validation.schema_result.to_h }
      yield attributes
    else
      validations.each do |validation|
        add_errors_for(validation) unless validation.success?
      end
    end
  end

  private

  def add_errors_for(resource)
    if resource.errors.is_a?(Dry::Validation::MessageSet)
      add_dry_validation_errors_for(resource)
    else
      add_active_model_errors_for(resource)
    end
  end

  def add_dry_validation_errors_for(resource)
    resource.errors(full: true).each do |error|
      errors.add(error.path.join('.'), error.text.humanize)
    end
  end

  def add_active_model_errors_for(resource)
    resource.errors.each do |error|
      errors.add(error.attribute, "#{error.attribute.to_s.capitalize} #{error.message}")
    end
  end

end
