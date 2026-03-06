class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to task_path, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # ===== ここに削除機能を追加 =====
  def destroy
    # 1. 削除したいタスクを見つける
    @task = Task.find(params[:id])

    # 2. データベースから完全に消し去る（destroy）
    @task.destroy

    # 3. 一覧画面に戻る
    redirect_to tasks_path, notice: "レポートを削除しました！"
  end

  private # ← この上に書きます

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
