# typed: true
# frozen_string_literal: true

module Maintenance
  class UpdatePostsSorbetTask < MaintenanceTasks::Task
    extend T::Sig

    class << self
      attr_accessor :fast_task
    end

    sig { returns(ActiveRecord::Collection) }
    def collection
      Post.all
    end

    sig { returns(Integer) }
    def count
      collection.count
    end

    sig { params(post: Post).void }
    def process(post)
      sleep(1) unless self.class.fast_task

      post.update!(content: "New content added on #{Time.now.utc}")
    end
  end
end
