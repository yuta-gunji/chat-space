== README

# DB設計
-----------------------------------------------------------------------

## users table
| Column | Type    | Options                                |
|:------:|:-------:|:--------------------------------------:|
| name   | string  | index: true, null: false, unique: true |
| mail   | string  | null: false                            |

### Association
+ has_many :groups, through: members
+ has_many :members
+ has_many :messages

-----------------------------------------------------------------------

## messages table
| Column   | Type              | Options                        |
|:--------:|:-----------------:|:------------------------------:|
| body     | text              | null: false                    |
| image    | string            |                                |
| group_id | references :group | null: false, foreign_key: true |
| user_id  | references :user  | null: false, foreign_key: true |

### Association
+ belongs_to :group
+ belongs_to :user
+ belongs_to :member

-----------------------------------------------------------------------

## groups table
| Column   | Type       | Options                                |
|:--------:|:----------:|:--------------------------------------:|
| name     | string     | index: true, null: false, unique: true |

### Association
+ has_many :messages
+ has_many :members
+ has_many :users, through: members

-----------------------------------------------------------------------

## members table
| Column   | Type              | Options                |
|:--------:|:-----------------:|:----------------------:|
| group_id | references :group | foreign_key: true      |
| user_id  | references :user  | foreign_key: true      |

### Association
+ belongs_to :user
+ belongs_to :group
+ has_many :messages

-----------------------------------------------------------------------
