#--
# $Id: interface_point.rb 361 2007-05-16 00:52:06Z keegan $
# Copyright 2004-2007 Keegan Quinn
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

# Each InterfacePoint instance represents a specific fixed physical
# location with a relationship to an Interface instance.
#
# This data is given in the form of latitude and longitude such as
# can easily be obtained using common GPS equipment.
class InterfacePoint < ActiveRecord::Base
  default_scope :order => 'interface_id, updated_at DESC'

  belongs_to :interface

  validates_presence_of :interface_id
  validates_numericality_of :latitude
  validates_numericality_of :longitude
  validates_numericality_of :height
  validates_numericality_of :error
  validates_presence_of :description
  validates_uniqueness_of :description, :scope => :interface_id
end
