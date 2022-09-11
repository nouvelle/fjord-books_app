# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  # GET /reports or /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1 or /reports/1.json
  def show
    report = Report.find(params[:id])
    @comments = report.comments
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    # 下記の１行を追加するとログインユーザの持ちものから探すようにするので、
    # 他者のものを修正しようとすると、findメソッドが ActiveRecord::RecordNotFound の例外を出す。
    # development環境だとエラー画面になるが、production環境なら404になる
    # @report = current_user.reports.find(params[:id])
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    if @report.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    if @report.update(report_params)
      redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :contents)
  end

  def check_user
    redirect_to report_url, alert: t('controllers.common.unauthorized_operation') if current_user.id != @report.user_id
  end
end
