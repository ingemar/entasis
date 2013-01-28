# -*- encoding: utf-8 -*-
class Car
  include Entasis::Model
  include Entasis::TransposeKeys

  attributes :speed, :left_front_door, :right_front_door
end
