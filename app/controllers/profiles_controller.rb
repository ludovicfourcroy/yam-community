class ProfilesController < ApplicationController
  before_action :skip_authorization
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @last_review = @user.received_reviews.last
    @reviewer = @last_review.reviewer
    @review = Review.new
    @reviews = Review.where(receiver_id: @user).order(created_at: :desc)
    @premium_subscription = PremiumSubscription.last
  end

  def my_profile

    @user = current_user
    @preference = current_user.preference
    @reviews = Review.where(receiver_id: current_user)
    @last_review = Review.where(receiver_id: current_user).last
    @reviewer = User.find(@last_review.reviewer_id)
    @premium_subscription = PremiumSubscription.last
  end

  private

  def review_profile
    params.require(:profile).permit(:user, :profile_id, :reviews)
  end
end
