class NotesController < ApplicationController
  load_and_authorize_resource
  before_action :set_note, only: [:show, :edit, :update, :destroy ]

  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note_products = NoteProduct.all
    @products = Product.all
    @note = Note.new
   
  end

  def edit
    @products = Product.all
    @note_products = NoteProduct.all
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to @note, notice: "Note was successfully created"
    else
      @note_products = NoteProduct.all
      @products = Product.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: "Note was successfully updated"
    else
      render "edit"
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path, status: :see_other, notice: "Note was successfully destroyed."
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:id, :name, note_products_attributes: [:id, :quantity, :product_id, :note_id, :_destroy])
    end
end
