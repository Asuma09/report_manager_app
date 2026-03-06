class DataController < ApplicationController
  def new
    @task = Task.find(params[:task_id])
    @datum = @task.data_list.build
  end

  def create
    # 1. もう一度「親（タスク）」を探し出す（Webの仕組み上、画面が変わると忘れてしまうため）
    @task = Task.find(params[:task_id])

    # 2. フォームから送られてきたデータで、親に紐づく「子（資料）」を作る
    @datum = @task.data_list.build(datum_params)

    # 3. データベースに保存する
    if @datum.save
      # 成功したらタスク一覧画面に戻る
      redirect_to tasks_path, notice: "資料を追加しました！"
    else
      # 失敗したら入力画面を出し直す
      render :new, status: :unprocessable_entity
    end
  end

  private

  # セキュリティのための設定（ストロングパラメーター）
  def datum_params
    # data_type（種類）、content（URL）、file（ファイル本体）の3つを許可する
    params.require(:datum).permit(:data_type, :content, :file)
  end
end
