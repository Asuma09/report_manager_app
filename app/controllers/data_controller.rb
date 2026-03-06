class DataController < ApplicationController
  def new
    @task = Task.find(params[:task_id])
    @datum = @task.data_list.build
  end

  def create
    @task = Task.find(params[:task_id])

    # 2. フォームから送られてきたデータで、親に紐づく「子（資料）」を作る
    @datum = @task.data_list.build(datum_params)
    if @datum.save
      redirect_to tasks_path, notice: "資料を追加しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # セキュリティのための設定（ストロングパラメーター）
  def datum_params
    params.require(:datum).permit(:data_type, :content, :file)
  end
end
