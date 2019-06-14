# frozen_string_literal: true

# Pundit access control policy for ContactsController.
class ContactPolicy < ApplicationPolicy
  def show?
    return true unless @record.hidden

    create?
  end

  def create?
    return false unless @user

    @user.try(:admin?) || @record.user == @user ||
      @record.group&.users&.include?(@user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
