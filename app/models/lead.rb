class Lead < ApplicationRecord
    require "date"
    has_one_attached :Attachment
    after_save :add_file_to_dropbox
    
    def add_file_to_dropbox
        puts "************ attachemnt != nil ****************"
        list_folders = self.list_of_folders_dropbox
        puts "---------- LISTE DES FOLDERS dans Dropbox ------------------ "
        puts list_folders
        folder_exist = false
        # verification de lexistence du dossier dans Dropbox
        list_folders.each do |l|
            if l == self.lead_company_name
            folder_exist = true
            puts "--------------- Folder Exist ------------ "
            end
        end
        # le dossier nexiste pas dans dropbox
        if !folder_exist
            self.add_folder_to_dropbox
            puts "********* Ajout DOSSIER dans Dropbox ****************"
        end
        begin
            puts "**************** Ajout du FICHIER dans le DOSSIER dans Dropboxx ******************************"
            @client = DropboxApi::Client.new(ENV['DROPBOX_ACCESS_TOKEN'])
            content = self.attachment
            company_name = self.lead_company_name
            attachment_name = self.file_name
            current_time = DateTime.now.strftime("%M%S")
            @client.upload("/#{company_name}/#{current_time}_#{attachment_name}", content)

            puts "**************** FIN DE L'AJOUT du fichier dans le dosssier dans Dropboxx ******************************"
        end
        puts "********************* END  ********************"
    #   end
    end

    def list_of_folders_dropbox
      @client = DropboxApi::Client.new(ENV['DROPBOX_ACCESS_TOKEN'])
      list_folder_result = @client.list_folder('')
      entries = list_folder_result.entries
      folders = entries.select { |e| e.is_a?(DropboxApi::Metadata::Folder) }
      folders.collect! { |f_met| f_met.name }
    end
    def add_folder_to_dropbox
      @client = DropboxApi::Client.new(ENV['DROPBOX_ACCESS_TOKEN'])
      company_name = self.lead_company_name
      begin
        puts "******************* Creation du dossier dans Dropbox *********************"
        @client.create_folder("/#{company_name}")
        puts "******************* FIN de la Creation du dossier dans Dropbox *********************"
      end
    end
end
