class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  # GET /interventions
  # GET /interventions.json
  def index
    @interventions = Intervention.all
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show

  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
    @customers = Customer.all
    @buildings = Building.all
    @batteries = Battery.all
    @columns = Column.all
    @elevators = Elevator.all
    @employees = Employee.all
  end

  def get_buildings
    customer_id = params[:customer_id]
    buildings = Building.where(customer_id: customer_id)
    puts buildings
    render json: buildings
  end

  def get_batteries
    building_id = params[:building_id]
    batteries = Battery.where(building_id: building_id)
    puts batteries
    render json: batteries
  end

  def get_columns
    battery_id = params[:battery_id]
    columns = Column.where(battery_id: battery_id)
    puts columns
    render json: columns
  end

  def get_elevators
    column_id = params[:column_id]
    elevators = Elevator.where(column_id: column_id)
    puts elevators
    render json: elevators
  end

  # GET /interventions/1/edit
  def edit
  end

  def intervention_params
    params.require(:intervention).permit!
  end

  # POST /interventions
  # POST /interventions.json
  def create
    p 'create'
    @intervention = Intervention.new
    @intervention.author = current_employee.id
    @intervention.customer_id = params[:customers_selection]
    @intervention.building_id = params[:buildings_selection]
    @intervention.battery_id = params[:batteries_selection]
    @intervention.column_id = params[:columns_selection]
    @intervention.elevator_id = params[:elevators_selection]
    @intervention.employee_id = params[:employees_selection]
    @intervention.report = params[:report_message]
    employee_id = @intervention.employee_id
    @employee = Employee.find(employee_id)
    customer_id = @intervention.customer_id
    @customer = Customer.find(customer_id)

    puts @intervention
    p @intervention.valid?
    @intervention.save!
    
    respond_to do |format|
      if @intervention.save
        create_intervention_ticket(@intervention, @employee, @customer)
        p 'Intervention was successfully created.'
        format.html { redirect_to @intervention, notice: 'Intervention was successfully created.' }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new, notice: 'Intervention was not successfully created.' }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_intervention_ticket(intervention, employee, customer)
    @client = ZendeskAPI::Client.new do |config|
      config.url = "https://rocketelevators5361.zendesk.com/api/v2"
      config.username = ENV["ZENDESK_USERNAME"]
      config.token = ENV["ZENDESK_API_TOKEN"]
      config.password = ENV["ZENDESK_PASSWORD"]
      config.retry = true
      config.raise_error_when_rate_limited = false
      require 'logger'
      config.logger = Logger.new(STDOUT)
    end
    ticket = ZendeskAPI::Ticket.new(@client, :id => 1)
    ZendeskAPI::Ticket.create!(@client, :subject => "Requesting support at #{@customer.company_name}", 
    :comment => { :value => "
    A new intervention has been created by employee ##{current_employee.id}.

      Customer: #{@customer.company_name}
      ==================================
      Customer id: ##{@customer.id}
      Building id: ##{@intervention.building_id.to_s}
      Battery id: ##{@intervention.battery_id.to_s}
      Column id: ##{@intervention.column_id.to_s}
      Elevator id: ##{@intervention.elevator_id.to_s}
      ===================================

    This Intervention has been assigned to #{@employee.firstname} #{@employee.lastname}.

    Report:
    #{@intervention.report}
    "
    },  
    :priority => "urgent",
    :type => "problem",
    requester: {"name": "Employee ##{current_employee.id}"})
  end
  # PATCH/PUT /interventions/1
  # PATCH/PUT /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to @intervention, notice: 'Intervention was successfully updated.' }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @intervention.destroy
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: 'Intervention was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intervention_params
      params.require(:intervention).permit(:author, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :starting_time, :ending_time, :result, :report, :status)
    end


  end
