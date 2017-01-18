import java.util.List;

public class GraphDriver {
    public static void main(String[] args) {
        Graph graph = new Graph();
        Graph.Vertex v1 = graph.addVertex("1", "u1", false);
        Graph.Vertex v2 = graph.addVertex("2", "u1", false);
        Graph.Vertex v3 = graph.addVertex("3", "u1", false);
        Graph.Vertex v4 = graph.addVertex("4", "u1", false);
        graph.addEdge(v2, v1, 500);
        graph.addEdge(v3, v2, 500);
        graph.addEdge(v4, v3, 500);
        graph.addEdge(v2, v4, 500);
        graph.addEdge(v3, v1, 500);
        graph.addEdge(v1, v2, 500);
        graph.addEdge(v3, v4, 500);

        graph.freeze();

        graph.print();

        graph.generateIntegerProgrammingEquations("dummyOutput.lp");

        /*
        // couple of different way to get either receiver or sender vertices
        List<Graph.Vertex> senderVertexList = graph.getSenderVertexList();
        List<Graph.Vertex> receiverVertexList = graph.getReceiverVertexList();
        for (Graph.Vertex v: receiverVertexList) {
            System.out.println("Vertex: " + v.toString()); // do something with the Vertex
        }
        Graph.Vertex[] senderVertexArray = graph.getSenderArray();
        Graph.Vertex[] receiverVertexArray = graph.getReceiverArray();
        */

        // get the edges
        /*
        for (Graph.Vertex v: receiverVertexArray) {
            // for (Graph.Edge e: v.EDGES) { // either get the edges this way or the following way
            for (Graph.Edge e: v.edges) {
                System.out.println("Vertex " + v.name + ", Edge: " + e.toString()); // do something with the Edge
            }
        }
        */
    }
}
