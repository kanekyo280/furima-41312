# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| password_digest    | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_reading | string | null: false               |
| last_name_reading  | string | null: false               |
| date               | date   | null: false               |

### Association

- has_many :items
- has_many :saleslogs

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| product_name   | string     | null: false                    |
| description    | string     | null: false                    |
| category       | string     | null: false                    |
| product_status | string     | null: false                    |
| postage_payer  | string     | null: false                    |
| delivery_area  | string     | null: false                    |
| delivery_days  | string     | null: false                    |
| price          | integer    | null: false                    |
| shopping_fee   | integer    | null: false                    |
| profit         | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :saleslog

## saleslogs テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_many :deliveries

## deliveries テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| postal_code           | integer    | null: false                    |
| address_prefecture    | string     | null: false                    |
| address_city          | string     | null: false                    |
| address_house_number  | string     | null: false                    |
| address_building_name | string     | null: false                    |
| phone_number          | integer    | null: false                    |
| saleslog              | references | null: false, foreign_key: true |

### Association

- belongs_to :saleslog
