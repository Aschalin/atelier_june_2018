require "rails_helper"

RSpec.describe ReservationsHandler, type: :service do
  let(:user) { User.new }
  let(:book) { Book.new }
  subject { described_class.new(user, book) }

  describe '#reserve' do

    before {
      allow(subject).to receive_message_chain(:can_reserve?).with(no_args).and_return(can_be_reserved)
    }

    context 'without available book' do
      let(:can_be_reserved) { false }
      it {
        expect(subject.reserve).to eq('Book is not available for reservation')
      }
    end

    context 'with available book ' do
      let(:can_be_reserved) { true }

      before {
        allow(book).to receive_message_chain(:reservations, :create).with(no_args).
        with(user: user, status: 'RESERVED').and_return(true)
      }

      it {
        expect(subject.reserve).to be_truthy
      }
    end
  end

  describe '#take' do

    before {
      allow(subject).to receive_message_chain(:can_take?).with(no_args).and_return(can_be_taken)
    }

    context 'with book taken' do
      let(:can_be_taken) { false }
      it {
        expect(subject.take).to eq('Book is already taken')
      }
    end

    context 'without book taken' do
      let(:can_be_taken) {true}

      before {
        allow(subject).to receive_message_chain(:available_reservation, :present?).with(no_args).
        and_return(book_available)
      }

      context ' and reservation was made' do
        let(:book_available) {false}

        before {
          allow(book).to receive_message_chain(:reservations, :create).with(no_args).
          with(user: user, status: 'TAKEN').and_return(true)
        }
        it {
          expect(subject.take).to be_truthy
        }
      end

      context ' and reservation wasn\'t made' do
        let(:book_available) {true}

        before {
          allow(subject).to receive_message_chain(:available_reservation, :update_attributes).with(no_args).
          with(status:'TAKEN').and_return(true)
        }

        it {
          expect(subject.take).to be_truthy
        }
      end
    end
  end
end

