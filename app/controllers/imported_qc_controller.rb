class ImportedQcController < ApplicationController

    # GET /ImportedQc
    # GET /ImportedQc.json
    def index
      @imported_qcs = ImportedQc.all
      @no_records_by_date = ImportedQc.count("DATE(qcdate)")
      @imported_files_by_date = ImportedQc.group("DATE(qcdate)").count

      StatHat::API.ez_post_value("QC-records-rb", "craig.webster@heartofengland.nhs.uk", @no_records_by_date)

      @date = params[:date] ? Date.parse(params[:date]) : Date.today

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @imported_files_by_date }
    end

    # GET /imported_files/1
     # GET /imported_files/1.json
     def show
       @imported_file = ImportedQc.find(params[:id])

       respond_to do |format|
         format.html # show.html.erb
         format.json { render json: @imported_file }
       end
     end

     # GET /imported_files/new
     # GET /imported_files/new.json
     def new
       @imported_file = ImportedQc.new

       respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @imported_file }
       end
     end

     # GET /imported_files/1/edit
     def edit
       @imported_file = ImportedQc.find(params[:id])
     end

     # POST /imported_files
     # POST /imported_files.json
     def create
       @imported_file = ImportedQc.new(params[:imported_file])

       respond_to do |format|
         if @imported_file.save
           format.html { redirect_to @imported_file, notice: 'Analyser class was successfully created.' }
           format.json { render json: @imported_file, status: :created, location: @imported_file }
         else
           format.html { render action: "new" }
           format.json { render json: @imported_file.errors, status: :unprocessable_entity }
         end
       end
     end

     # PUT /imported_files/1
     # PUT /imported_files/1.json
     def update
       @imported_file = ImportedQc.find(params[:id])

       respond_to do |format|
         if @imported_file.update_attributes(params[:imported_file])
           format.html { redirect_to @imported_file, notice: 'Analyser class was successfully updated.' }
           format.json { head :no_content }
         else
           format.html { render action: "edit" }
           format.json { render json: @imported_file.errors, status: :unprocessable_entity }
         end
       end
     end

     # DELETE /imported_files/1
     # DELETE /imported_files/1.json
     def destroy
       @imported_file = ImportedQc.find(params[:id])
       @imported_file.destroy

       respond_to do |format|
         format.html { redirect_to imported_qc_url }
         format.json { head :no_content }
       end
     end


    end
  end
