class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
#全行でpresence trueをする
with_options presence: true do
  validates :nickname
  validates :birthday
#この２行だけひらがな、カタカナ、漢字の指定
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]/ } do
    validates :first_name
    validates :last_name
  end
#この２行だけ　カタカナだけの指定
  with_options format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/ } do
    validates :first_name_reading
    validates :last_name_reading
  end
end

PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
validates :password, format: {with: PASSWORD_REGEX}, confirmation: true

end
