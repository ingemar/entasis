# -*- encoding: utf-8 -*-
class Car
  include Entasis::Model

  attributes :speed, allow_unknown: true
end
