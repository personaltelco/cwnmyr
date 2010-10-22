#--
# $Id: service.rb 485 2007-07-09 12:08:49Z keegan $
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

# Each Service instance represents a type of network service or system
# process.  HostService instances can be used to form a relationship
# with Host instances which offer these services.
class Service < ActiveRecord::Base
  default_scope :order => 'port, protocol, name ASC'

  has_many :host_services

  validates_length_of :code, :minimum => 1
  validates_length_of :code, :maximum => 64
  validates_uniqueness_of :code
  validates_format_of :code, :with => %r{^[-_a-zA-Z0-9]+$},
    :message => 'contains unacceptable characters',
    :if => Proc.new { |o| o.code && o.code.size > 1 }
  validates_length_of :name, :minimum => 1
  validates_length_of :name, :maximum => 128
  validates_each :protocol do |record, attr, value|
    unless value.blank?
      record.errors.add attr, 'is invalid' if value != 'tcp' and value != 'udp'
    end
  end
  validates_numericality_of :port, :allow_nil => true
  validates_each :port do |record, attr, value|
    unless value.blank?
      record.errors.add attr, 'is invalid' if value < 0 or value > 65536
    end
  end

  # Find a Service record based on an identifier from a request parameter.
  def self.find_by_param(*args)
    find_by_code *args
  end

  # This method returns an identifier for use in generating request
  # parameters.
  def to_param
    self.code
  end

  # Converts the value of the +name+ attribute into a link-friendly
  # String instance.
  def stripped_name
    self.name.gsub(/<[^>]*>/,'').to_url
  end

  protected

  before_validation_on_create :set_defaults

  # Set default values.
  def set_defaults
    self.code = self.stripped_name if self.code.blank?
  end
end
