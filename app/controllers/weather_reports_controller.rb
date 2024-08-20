class WeatherReportsController < ApplicationController
  before_action :set_weather_report, only: %i[ show edit update destroy ]

  # GET /weather_reports or /weather_reports.json
  def index
    @weather_reports = WeatherReport.all
  end

  # GET /weather_reports/1 or /weather_reports/1.json
  def show
  end

  # GET /weather_reports/new
  def new
    @weather_report = WeatherReport.new
  end

  # GET /weather_reports/1/edit
  def edit
  end

  # POST /weather_reports or /weather_reports.json
  def create
    @weather_report = WeatherReport.new(weather_report_params)

    respond_to do |format|
      if @weather_report.save
        format.html { redirect_to weather_report_url(@weather_report), notice: "Weather report was successfully created." }
        format.json { render :show, status: :created, location: @weather_report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_reports/1 or /weather_reports/1.json
  def update
    respond_to do |format|
      if @weather_report.update(weather_report_params)
        format.html { redirect_to weather_report_url(@weather_report), notice: "Weather report was successfully updated." }
        format.json { render :show, status: :ok, location: @weather_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weather_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_reports/1 or /weather_reports/1.json
  def destroy
    @weather_report.destroy

    respond_to do |format|
      format.html { redirect_to weather_reports_url, notice: "Weather report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_report
      @weather_report = WeatherReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weather_report_params
      params.fetch(:weather_report, {})
    end
end
