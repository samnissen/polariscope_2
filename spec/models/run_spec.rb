require 'rails_helper'

RSpec.describe Run, type: :model do
  before(:each) do
    @run = create(:run)
  end

  describe "dateify" do
    before(:each) do
      @default_date_range_const = Run::DEFAULT_DATERANGE
    end
    it "should reject improper code" do
      wrap_env('POLARISCOPE_ALLOWED_RUN_DATE_RANGE' => "return 'Hello!'") do
        env_var = ENV['POLARISCOPE_ALLOWED_RUN_DATE_RANGE']
        result = Run.dateify(env_var)

        expect(result).to eq(@default_date_range_const)
      end
    end
    it "should return default when nil" do
      wrap_env('POLARISCOPE_ALLOWED_RUN_DATE_RANGE' => nil) do
        env_var = ENV['POLARISCOPE_ALLOWED_RUN_DATE_RANGE']
        result = Run.dateify(env_var)

        expect(result).to eq(@default_date_range_const)
      end
    end
    it "should return ActiveRecord date-time when given" do
      result = Run.dateify('3.months.ago')

      dt = 3.months.ago
      expect(result).to be_between(dt - 12.hours, dt + 12.hours)
    end
  end

  describe "prune" do
    before(:each) do
      @default_date_range_const = Run::DEFAULT_DATERANGE
    end
    it "should remove old records" do
      no = 10

      wrap_env('POLARISCOPE_ALLOWED_RUN_DATE_RANGE' => "6.months.ago") do
        no.times do |n|
          r = create(:run, { created_at: eval("#{n+2}.weeks.ago") })
        end
      end

      wrap_env('POLARISCOPE_ALLOWED_RUN_DATE_RANGE' => "1.week.ago") do
        expect{create(:run)}.to change{Run.count}.by((-(no-1)))
      end
    end
    it "should not remove new records" do
      no = 10

      wrap_env('POLARISCOPE_ALLOWED_RUN_DATE_RANGE' => "6.months.ago") do
        no.times do |n|
          r = create(:run, { created_at: eval("#{n+2}.weeks.ago") })
        end

        expect{create(:run)}.to change{Run.count}.by(1)
      end
    end
  end

  describe "compile" do
    it "should compile any belongs_to testsets with test_actions" do
      @col = create(:collection)
      @ts1 = create(:testset, collection: @col)
      @ta1 = create(:test_action, testset: @ts1)

      @ts2 = create(:testset, collection: @col)
      @ta1 = create(:test_action, testset: @ts2)

      @ts3 = create(:testset, collection: @col)
      @ts4 = create(:testset, collection: @col)

      run = create(:run_with_compile, test_ids: [@ts1.id, @ts2.id, @ts3.id])

      expect(run.run_tests.size).to eq(2)

      test_ids_from_tests = [@ts1.id, @ts2.id]
      test_ids_from_run = run.run_tests.map{|rt| rt.testset.id}.compact
      expect(test_ids_from_tests).to eq(test_ids_from_run)
    end
  end

end
