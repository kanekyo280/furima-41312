# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_reading | string | null: false               |
| last_name_reading  | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :saleslogs

## items テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| product_name      | string     | null: false                    |
| description       | text       | null: false                    |
| category_id       | integer    | null: false                    |
| product_status_id | integer    | null: false                    |
| postage_payer_id  | integer    | null: false                    |
| delivery_area_id  | integer    | null: false                    |
| delivery_day_id   | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

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
| postal_code           | string     | null: false                    |
| address_prefecture_id | integer    | null: false                    |
| address_city          | string     | null: false                    |
| address_house_number  | string     | null: false                    |
| address_building_name | string     |                                |
| phone_number          | integer    | null: false                    |
| saleslog              | references | null: false, foreign_key: true |

### Association

- belongs_to :saleslog
