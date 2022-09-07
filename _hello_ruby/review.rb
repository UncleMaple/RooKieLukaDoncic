=begin
1.
已知字符串 str = 'xyz165c5671lki6789cc123'
找出是连续顺序并且4位以上的数字，如str变量中的6789,使用非正则方法
=end

str = 'xyz165c5671lki6789cc123'
res = []
tmp = ""
str.split('').each do |c|
  if ((0..9).to_a.map(&:to_s)).include?(c) && (tmp.size == 0 || tmp.split('').last.to_i + 1 == c.to_i)
    tmp += c
  else
    res << tmp.to_i if tmp.size >= 4
    tmp = ''
  end
end

res

=begin
2.
attrs = [
    { gender: 'male', age: 18 },
    { gender: 'female', age: 25 },
    { gender: 'male', age: 22 },
    { gender: 'female', age: 22 }
]
以数组中元素中的age和gender两个字段做倒序排列
=end

attrs.sort_by { |a| (a[:age]) }.reverse
attrs.sort_by { |a| [a.age, a.gender] }.reverse

=begin

3.
请实现以下类Store的功能
s = Store.new do |x|
  x << 1
  x << 3
  x << proc { 'hello' }
  x << proc { 6 * 100 }
end


s.next # => 1
s.next # => 3
s.next # => 'hello'
s.next # => 600
s.next # => raise error 'EOF'

=end

class Store
  attr_accessor :res

  def initialize
    @res = Array.new
    if block_given?
      yield(@res)
    end
  end

  def <<(obj)
    @res << obj
  end

  def next
    if @res.size > 0
      @res.shift
    else
      raise 'EOF'
    end
  end
end

=begin

4.
class User
  include Injection
  field :name, 'name'
  field :gender, 'gender'
  field :age, 'info.age'
  field :say_hello, proc { |me| "my name is #{me.name}" }

  def data
    {
      'info' => { 'age' => 24 },
      'gender' => 'female',
      'name' => 'Ruby'
    }
  end
end

实现 Injection Module:
user = User.new
user.name # => 'Ruby'
user.gender # => 'female'
user.say_hello # => 'my name is Ruby'
user.fields # => [:name, :gender, :age, :say_hello]

=end



module Injection
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :fields

    def field(name, type)
      @fields = [] unless @fields.class == Array
      @fields << name
      define_method name do
        if block_given?
          yield(self)
        else
          self.data.dig(type)
        end
        # type
      end
    end
  end

end

class User
  include Injection
  field :name, 'name'
  field :gender, 'gender'
  field :age, 'info.age'
  field :say_hello, proc { |me| "my name is #{me.name}" }

  def data
    {
      'info' => { 'age' => 24 },
      'gender' => 'female',
      'name' => 'Ruby'
    }
  end
end

=begin
5.

# 纠正下面代码有错误的地方
class User < ActiveRecord::Base
  after_save :set_nickname

  private
     def set_nickname
        update(nickname: "Mr.#{name}")
     end
 end

User.create(name: "name_1")
=end

update(nickname: "Mr.#{name}") if name_changed?


=begin
6.

# 1至9九个数字组成两个四位数和一个一位数（九个数字正好用完,不重复）
# 问满足其中一个四位数乘那个一位数正好等于另一个四位数的组合方法
=end

res =  []
(2..9).each do |i|
  (1234..9876).each do |j|

    next if j.to_s.split('').map(&:to_i).include?(i)

    mul = (i * j).to_s.split('').map(&:to_i)
    next unless mul.size == 4
    rest = (1..9).to_a - [i] - j.to_s.split('').map(&:to_i)

    if mul.sort == rest.sort
      p mul
      p rest
      res << [i, j, i*j] if mul.sort == rest.sort
    end

  end
end

res





# second
#
# Ruby:
#
# 1. 如何 def 一个method? 使用 private, protected, public 的区别.
#
# 2. ruby中 class, 和 module 的区别是什么? 什么情况下使用 class, 什么情况下使用 module?
#
# 3. 简述一下 如何使用 class_eval, 什么是 singleton class, singleton_method ? 写一个例子.
#
# 4. 用ruby 写一个class Robot 机器人.
#
# a.他拥有名字, 编号,
#
# b.功能: 1.可以念出自己的名字和编号, 2.可以复读你说的话.
#
# 5. 请实现以下类Storage的功能
#
# s = Storage.new do |x|
#
# x << 1
#
# x << 3
#
# x << proc { 'hello' }
#
# end
#
# s.next # => 1
#
# s.next # => 3
#
# s.next # => 'hello'
#
# s.next # => raise error ‘EOF'
#
# Rails:
#
# 1. 简述一下 Active Record 的ORM 框架, 映射关系.
#
# 2. rails 的 has_many :through 与 has_and_belongs_to_many的区别?
#
# 3. 什么是单表继承(STI)? 什么情况下使用STI, 写一个单标继承的结构, 以及查询方法.
#
# 4. rails的 7个路由route 有哪些?
#
# 5. 简述一下 rails 的 includes, joins, preload, eager_load 的区别什么? 什么是 left_join, right_join, inner_join.
#
# 6. 什么是 ActiveSupport::Concern, 什么情况下使用它, 写一个简单的 使用样例.
#
# 7. rails中 使用过哪些常用gem包, 举2-3个gem介绍一下, 使用他能完成什么功能.
#
# 8. http 有哪些请求method.
#
# 9. cookies 和 sessions 的区别. 什么情况使用cookies? 什么情况下使用sessions
#
# 10. 指出下面代码会导致bug，并修复。
#
# class User < ActiveRecord::Base
#
# after_save :set_name
#
# private
#
# def set_name
#
# self.update(name: ‘Lala’)
#
# end
#
# end
#
# User.create(name: "Woe")
#
# 11. 购物车题：
#
# 现有product 商品表，表里的字段包括：商品名称和单价，需要让用户可以在界面中选择商品、输入购买数量、并添加到购物车，需能够显示计算出所选商品的总价。（仅设计出数据表和相对应的model）

=begin
Product

id
name
price

LineItem

id
product_id
shopping_cart_id
count


ShoppingCart

id
total

lineItem has_one product
product belongs_to lineItem

ShoppingCart has_many line_items
line_items belongs_to ShoppingCart

ShoppingCart has_many products through lineItems

=end
