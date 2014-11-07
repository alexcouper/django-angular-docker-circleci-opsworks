describe('dummy page', function() {

    it('should count visits', function() {
        var counterSpan = element(by.css('#counter'));
        browser.get('/dummy/');
        expect(counterSpan.getText()).toEqual('Visits: 1.');
        browser.get('/dummy/');
        expect(counterSpan.getText()).toEqual('Visits: 2.');
    });

    it('should contain a greeting', function() {
        var greeting = element(by.css('p.greeting'));
        browser.get('/dummy/');
        expect(greeting.getText()).toContain('Hello');
    });


});
