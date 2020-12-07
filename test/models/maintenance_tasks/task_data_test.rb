# frozen_string_literal: true
require 'test_helper'

module MaintenanceTasks
  class TaskDataTest < ActiveSupport::TestCase
    test '.find returns a TaskData for an existing Task' do
      task_data = TaskData.find('Maintenance::UpdatePostsTask')
      assert_equal 'Maintenance::UpdatePostsTask', task_data.name
    end

    test '.find returns a TaskData for a deleted Task with a Run' do
      task_data = TaskData.find('Maintenance::DeletedTask')
      assert_equal 'Maintenance::DeletedTask', task_data.name
    end

    test '.find raises if the Task does not exist' do
      assert_raises Task::NotFoundError do
        TaskData.find('Maintenance::DoesNotExist')
      end
    end

    test '.available_tasks returns a list of Tasks as TaskData' do
      expected_task_names = [
        'Maintenance::ErrorTask',
        'Maintenance::UpdatePostsTask',
        'MaintenanceTasks::TaskJobTest::TestTask',
      ]
      assert_equal expected_task_names,
        TaskData.available_tasks.map(&:name).sort
    end

    test '#to_s returns the name of the Task' do
      task_data = TaskData.new('Maintenance::UpdatePostsTask')

      assert_equal 'Maintenance::UpdatePostsTask', task_data.to_s
    end

    test '#runs returns the Active Record relation of the runs associated with a Task' do
      run = maintenance_tasks_runs(:update_posts_task)
      task_data = TaskData.new('Maintenance::UpdatePostsTask')

      assert_equal 1, task_data.runs.count
      assert_equal run, task_data.runs.first
    end

    test '#last_run returns the last Run associated with the Task' do
      Run.create!(
        task_name: 'Maintenance::UpdatePostsTask',
        status: :succeeded
      )
      latest = Run.create!(task_name: 'Maintenance::UpdatePostsTask')
      task_data = TaskData.new('Maintenance::UpdatePostsTask')

      assert_equal latest, task_data.last_run
    end
  end
end
