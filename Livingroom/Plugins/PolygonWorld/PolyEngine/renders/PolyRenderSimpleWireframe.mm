#import "PolyRenderSimpleWireframe.h"
//#import "CGALEnumerator.h"

@implementation PolyRenderSimpleWireframe
@synthesize drawFillMode, drawGridMode;

-(id)init{
    if(self = [super init]){
        [self addPropF:@"zScale"];
        
        //[[self addPropF:@"drawMode"] setMaxValue:2];
        
        [self addPropF:@"lightX"];
        [self addPropF:@"lightY"];
        [self addPropF:@"lightZ"];
        
        [self setDrawFillMode:2];
    }
    return self;
}

-(void)controlDraw:(NSDictionary *)drawingInformation{
    
    
    glPolygonMode(GL_FRONT_AND_BACK , GL_FILL);
    ofFill();
    
    if(drawFillMode >= 1){
        
        
        ofSetColor(0,255,0);
        Arrangement_2::Face_iterator fit = [[engine arrangement] arrData]->faces_begin();    
        
        for ( ; fit !=[[engine arrangement] arrData]->faces_end(); ++fit) {
            ofSetColor(0,0,255);
            //                glEnable(GL_SMOOTH);
            
            
            if(drawFillMode == 1){
                glColor3f(0,0.3,0);
            }
            if(drawFillMode == 2){
                ofVec3f n = -calculateFaceNormal(fit) * PropF(@"zScale");
                // cout<<n.x<<"  "<<n.y<<"  "<<n.z<<endl;
                
                n *= ofVec3f(PropF(@"lightX"), PropF(@"lightY"), PropF(@"lightZ")).normalized();
                
                
                //                    cout<<n.x<<"  "<<n.y<<"  "<<n.z<<endl;
                float l = n.length();
                glColor3f(l,l,l);
            }
            
            glBegin(GL_POLYGON);
            
            
            if(!fit->is_fictitious()){
                if(fit->number_of_outer_ccbs() == 1){
                    Arrangement_2::Ccb_halfedge_circulator ccb_start = fit->outer_ccb();
                    Arrangement_2::Ccb_halfedge_circulator hc = ccb_start; 
                    
                    
                    do { 
                        if(drawFillMode == 3){
                            float z = hc->source()->data().z * PropF(@"zScale");
                            float r = z;
                            float b = -z;
                            glColor3f(r,0.2,b);
                        }
                        glVertex2d(CGAL::to_double(hc->source()->point().x()) , CGAL::to_double(hc->source()->point().y()));
                        ++hc; 
                    } while (hc != ccb_start); 
                }            
            }
            
            //        
            glEnd();   
            
        }      
    }
    
    if(drawGridMode > 0){
        ofSetColor(255,0,0);
        
        glPointSize(5);
        glBegin(GL_POINTS);
        
        //        CGALEnumerator * en = [CGALEnumerator vertexFromArr:[[engine arrangement] arrData]];
        
        Arrangement_2::Vertex_iterator vit = [[engine arrangement] arrData]->vertices_begin();    
        for ( ; vit !=[[engine arrangement] arrData]->vertices_end(); ++vit) {
            glVertex2d(CGAL::to_double(vit->point().x()) , CGAL::to_double(vit->point().y()));
            
        }    
        glEnd();  
        
        
        ofSetColor(0,255,0);
        glBegin(GL_LINES);
        Arrangement_2::Edge_iterator eit = [[engine arrangement] arrData]->edges_begin();    
        
        for ( ; eit !=[[engine arrangement] arrData]->edges_end(); ++eit) {
            glVertex2d(CGAL::to_double(eit->source()->point().x()) , CGAL::to_double(eit->source()->point().y()));
            glVertex2d(CGAL::to_double(eit->target()->point().x()) , CGAL::to_double(eit->target()->point().y()));
        }      
        
        glEnd(); 
    }
    
    //TODO: HULLS is sllooowww
    
    /* 
     glPointSize(1);
     
     ofSetColor(255,0,0);
     glPolygonMode(GL_FRONT_AND_BACK , GL_LINE);
     
     vector< Polygon_2> hull = [[engine arrangement] hulls];
     
     for(int i=0;i<hull.size();i++){
     
     glBegin(GL_POLYGON);
     Polygon_2::Vertex_iterator vit = hull[i].vertices_begin();
     for( ; vit != hull[i].vertices_end(); ++vit){
     glVertex2d(CGAL::to_double(vit->x()), CGAL::to_double(vit->y()));
     }
     glEnd();
     }
     */
    
}

@end
