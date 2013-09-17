#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2013 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

# This module includes some boilerplate code for pagination using scopes.
# #search_scope has to be overridden by the model itself and MUST return an
# actual scope (i.e. scope in Rails3 or named_scope in Rails2) or its corresponding hash.

module Pagination::Model

  def self.included(base)
    base.extend self
  end

  def self.extended(base)
    base.instance_eval do
      unloadable

      def paginate_scope!(scope, options = {})
        limit = options.fetch(:page_limit) || 10
        page = options.fetch(:page) || 1

        scope.paginate({ :per_page => limit, :page => page }) 
      end

      def search_scope(query)
        raise NotImplementedError, "Override in subclass #{self.name}"
      end
    end
  end
end
