class IssueSlipsController < ApplicationController
  def index
    @issue_slips = IssueSlip.all.order(:date)
  end

  def new
    @issue_slip = IssueSlip.new
    10.times { @issue_slip.documents.build }
  end

  def create
    @issue_slip = IssueSlip.new(issue_slip_params)

    if @issue_slip.save
      
      
      redirect_to issue_slips_path
    else
      render :new
    end
  end

  def show
    @issue_slip = IssueSlip.find(params[:id])
  end

  def edit
    @issue_slip = IssueSlip.find(params[:id])
  end

  def update
    @issue_slip = IssueSlip.find(params[:id])
    if @issue_slip.update(issue_slip_params)
      redirect_to issue_slips_path
    else
      render :edit
    end
  end

  def destroy
    @issue_slip = IssueSlip.find(params[:id])
    @issue_slip.destroy
    redirect_to issue_slips_path
  end

  private

  def issue_slip_params
    params.require(:issue_slip)
          .permit(:number, :date, :customer_id, :received_by, :licence_plate,
                  documents_attributes: %i[product_id qty _destroy])
  end
end
