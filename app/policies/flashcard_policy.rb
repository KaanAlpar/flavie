class FlashcardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.deck.user == user
  end

  def edit?
    record.deck.user == user
  end

  def update?
    record.deck.user == user
  end

  def destroy?
    record.deck.user == user
  end
end
