expect = chai.expect
grid = null

describe('leaf-grid', ->
  describe('default grid', ->
    beforeEach(->
      grid = document.getElementById('fix1')
    )

    it('should complete the parent\'s full width', ->
      fixture = document.getElementById('fixture')
      gridWidth = grid.getBoundingClientRect().width
      fixtureWidth = fixture.getBoundingClientRect().width
      expect(gridWidth).to.eql(fixtureWidth)
    )

    it('should respect full span', ->
      pieces = grid.querySelectorAll('.lf-grid__col--12-12')
      for piece in pieces
        expect(piece.getBoundingClientRect().width).to.eql(1000)
    )

    it('should respect the 12-column width', ->
      pieces = grid.querySelectorAll('.lf-grid__col--1-12')
      for piece in pieces
        expect(piece.getBoundingClientRect().width.toPrecision(3))
        .to.eql('83.3')
    )

    it('should start a new line when content is wider than the grid', ->
      piece = grid.querySelector('.lf-grid__col--6-12')
      expect(piece.getBoundingClientRect().left).to.eql(0)
    )
  )

  describe('gutter grid', ->
    it('should insert inner margin on all sides', ->
      grid = document.getElementById('fix2')
      innerBox = grid.querySelector('.lf-grid__box').children[0]
      expect(innerBox.getBoundingClientRect().left).to.be.above(0)
    )

    it('should respect nested grids', ->
      grid = document.getElementById('fix3')
      innerGrid = grid.querySelector('.lf-grid')
      expect(innerGrid.getBoundingClientRect().left).to.be.above(0)
    )
  )

  describe('responsive grid', ->
    it('should break the view at media breakpoints', ->
      grid = document.getElementById('fix4')
      piece = grid.querySelectorAll('.lf-grid__col--12-12')[1]
      if document.body.getBoundingClientRect().width < 568
        expect(piece.getBoundingClientRect().left).to.eql(0)
      else
        expect(piece.getBoundingClientRect().left).to.be.above(0)
    )
  )

  describe('vertical grid', ->
    it('should be able to display grid cells in a vertical way', ->
      grid = document.getElementById('fix5')
      piece = grid.querySelectorAll('.lf-grid__col--4-12')[1]
      expect(piece.getBoundingClientRect().left).to.eql(0)
    )
  )

  describe('right to left', ->
    it('should be RTL friendly', ->
      grid = document.getElementById('fix6')
      piece = grid.querySelectorAll('.lf-grid__col--3-12')[3]
      expect(Math.abs(piece.getBoundingClientRect().left)).to.eql(0)
    )
  )

  describe('grid alignments', ->
    it('should allow grid start alignment', ->
      grid = document.getElementById('fix7')
      piece = grid.querySelector('.lf-grid__col--2-12')
      expect(piece.getBoundingClientRect().left).to.eql(0)
    )

    it('should allow grid center align', ->
      grid = document.getElementById('fix8')
      piece = grid.querySelectorAll('.lf-grid__col--2-12')[1]
      expect(piece.getBoundingClientRect().left.toPrecision(4))
      .to.eql('416.7')
    )

    it('should allow grid end align', ->
      grid = document.getElementById('fix9')
      piece = grid.querySelectorAll('.lf-grid__col--2-12')[2]
      expect(piece.getBoundingClientRect().left.toPrecision(3))
      .to.eql('833')
    )
  )

  describe('priority ordering', ->
    it('should respect priority ordering', ->
      grid = document.getElementById('fix10')
      piece = grid.querySelectorAll('.lf-grid__col--2-12')[2]
      expect(piece.getBoundingClientRect().left).to.eql(0)
    )
  )

  # Pending tests
  xdescribe('column fit', -> return)
  xdescribe('column alignments', -> return)
  xdescribe('stretching', -> return)
)
