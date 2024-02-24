class User < ApplicationRecord
    has_secure_password
    belongs_to :level 

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true, 
    length: { in: 3..15},  
    format: { with: /\A[a-z0-9A-Z]+\z/, message: :invalid}
    validates :nro_document,  presence: true #Validar la presencia
    validates :name, presence: true #Validar la presencia
    validates :password_digest,  length: { minimum: 4 }
    validates :password_digest,  presence: true #Validar la presencia

    before_save :downcase_attributes

    def label_state(state)
        if state == 0 ; 'Inactivo'
        elsif state == 1 ; 'Activo'
        end 
    end  

    def label_level_user(level_user)
        if level_user == 1 ; 'Nuevo'
        elsif level_user == 2 ; 'Antiguo'
        elsif level_user == 3 ; 'Administrador'
        end 
    end  

    private
    def downcase_attributes
        self.username = username.downcase 
        self.email = email.downcase 
    end  


end
