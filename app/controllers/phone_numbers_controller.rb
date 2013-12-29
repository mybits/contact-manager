class PhoneNumbersController < ApplicationController
  before_action :set_phone_number, only: [:edit, :update, :destroy]

  def new
    @phone_number = PhoneNumber.new(contact_id: params[:contact_id], contact_type: params[:contact_type])
  end

  def edit
  end

  def create
    @phone_number = PhoneNumber.new(phone_number_params)

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to @phone_number.contact, notice: 'Phone number was successfully created.' }
        format.json { render action: 'show', status: :created, location: @phone_number }
      else
        format.html { render action: 'new' }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phone_number.update(phone_number_params)
        format.html { redirect_to @phone_number.contact, notice: 'Phone number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phone_number.destroy
    respond_to do |format|
      format.html { redirect_to @phone_number.contact }
      format.json { head :no_content }
    end
  end

  private
    def set_phone_number
      @phone_number = PhoneNumber.find(params[:id])
    end

    def phone_number_params
      params.require(:phone_number).permit(:number, :contact_id, :contact_type)
    end
end
